pushd %github_root%notes
@rem 2017-01-21 perl %git_work_dir%renenyffenegger.ch\notes\go.pl %*
perl .\scripts\create-html.pl %*
popd
