# 2022-07-24 pushd %github_root%notes
pushd %notes_dir%
perl .\scripts\create-html.pl %*
popd
