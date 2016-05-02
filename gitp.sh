if [ -z ${TQ84_GITHUB_PW+x} ]; then
  echo -n "TQ84_GITHUB_PW: "
  read TQ84_GITHUB_PW
  export TQ84_GITHUB_PW
fi

git-push.pl
