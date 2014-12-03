@setlocal enabledelayedexpansion

@set mark=%1

@if not defined mark (
  @echo you must specify a mark
  @exit /b
)

@rem This is why «setlocal enabledelayedexpansion» is the
@rem script's first line...
@set path_to_go=!cd_mark_%mark%!

@rem http://stackoverflow.com/a/3262891/180275
@endlocal && set path_to_go=%path_to_go%

@cd /d %path_to_go%

