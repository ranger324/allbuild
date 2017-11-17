git checkout -b "branch"
git submodule foreach --recursive git checkout master
git submodule foreach --recursive git checkout -b "branch"
