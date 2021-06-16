################################################################################################################
#
#   Git repository deployment.
#
#   This script is used to deploy any internal repositor to a public Git repository. It can also be used to
#   automatically tag this public repository with the relevant SDK version.
#
#   Note that this script is not design to be integrated with Xcode, and will instead be launched manually.
#
#   Requirement:
#    - Cocapods & git properly must be properly setup on your computer
#    - The current user must have write access rights on the target Git repository
#    - The current user must have read access rights on the internal Git repository
#
#   Variables:
#    - TAG_NAME: the Git tag that will be added on the commit
#    - COMMIT_MESSAGE: the commit message that will be visible in the public repository (REQUIRED)
#    - INTERNAL_REPOSITORY_NAME: the name of the Git internal repository (REQUIRED)
#    - INTERNAL_REPOSITORY: the SSH address of the Git internal repository (REQUIRED)
#    - PUBLIC_REPOSITORY_NAME: the name of the Git public repository (REQUIRED)
#    - PUBLIC_REPOSITORY: the SSH address of the Git public repository (REQUIRED)
#    - EXCLUDE_LIST: the optional path to a text file containing a list of files/directory to ignore during the copy
#
################################################################################################################


# Checking required variables for the deployment
if [ -z "${COMMIT_MESSAGE}" ] \
   || [ -z "${INTERNAL_REPOSITORY_NAME}" ] \
   || [ -z "${PUBLIC_REPOSITORY_NAME}" ] \
   || [ -z "${INTERNAL_REPOSITORY}" ] \
   || [ -z "${PUBLIC_REPOSITORY}" ]; then
  echo "❌ ERROR: missing required variables, cannot deploy the repository!"
  exit 1
fi


######################
# Repositories checkout
######################

echo "> Cloning required files…"

# Cleaning old repository if any
rm -Rf ./internal
rm -Rf ./public

# Internal
mkdir ./internal
( cd internal ; git clone "${INTERNAL_REPOSITORY}" )
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot checkout the internal repository!"
  exit 1
fi

# Public
mkdir ./public
( cd public ; git clone "${PUBLIC_REPOSITORY}" )
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot checkout the public repository!"
  exit 1
fi


######################
# Files copying
######################

echo "> Internal files copy"

# Removing everything in the public repository
# Note: don't remove the .git directory!
( cd "./public/${PUBLIC_REPOSITORY_NAME}" ; rm -Rf ./* )

# Copying from internal to public (and ignoring the '.git' directory)
if [ -z "${EXCLUDE_LIST}" ]; then
  # no exclude file is provided
  rsync -av --exclude=".git" "./internal/${INTERNAL_REPOSITORY_NAME}/" "./public/${PUBLIC_REPOSITORY_NAME}"
else
  # an exclude file is provided
  rsync -av --exclude=".git" --exclude-from="${EXCLUDE_LIST}" "./internal/${INTERNAL_REPOSITORY_NAME}/" "./public/${PUBLIC_REPOSITORY_NAME}"
fi
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot copy the internal files in the release directory!"
  exit 1
fi


######################
# Commit
######################

echo "> Commit & tagging…"

# Stage everything
( cd "./public/${PUBLIC_REPOSITORY_NAME}" ; git add . > /dev/null )
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot stage the new public repository!"
  exit 1
fi

# Commit
( cd "./public/${PUBLIC_REPOSITORY_NAME}" ; git commit -am "${COMMIT_MESSAGE}" --quiet )
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot commit the new public repository!"
  exit 1
fi


######################
# Repositories tagging
######################

# Public repository tagging if a tag name has been set
# Note: a tag name should always be used when the samples are updated because of SDK update…
if [ ! -z "${TAG_NAME}" ]; then

  ( cd "./public/${PUBLIC_REPOSITORY_NAME}" ; git tag "${TAG_NAME}" )
  if [ $? -ne 0 ]; then
    echo "❌ ERROR: Cannot tag the public samples repository!"
    exit 1
  fi

fi


######################
# Push in production
######################

echo "> Pushing in production…"

# Pushing the samples
( cd "./public/${PUBLIC_REPOSITORY_NAME}" ; git push --quiet )
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot push the commits on the public samples repository!"
  exit 1
fi

# Pushing the tags
( cd "./public/${PUBLIC_REPOSITORY_NAME}" ; git push --tags --quiet )
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Cannot push the tag on the public samples repository!"
  exit 1
fi
