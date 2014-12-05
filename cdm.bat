@rem
@rem      cdm SomeTag
@rem
@rem      cd into the direcotry in which
@rem      was called
@rem
@rem
@setlocal enabledelayedexpansion

@set tq84_mark=%1

@if not defined tq84_mark (
  @echo you must specify a mark
  @exit /b
)

@rem This is why «setlocal enabledelayedexpansion» is the
@rem script's first line...
@set path_to_go=!tq84_cd_mark_%tq84_mark%!

@rem http://stackoverflow.com/a/3262891/180275
@endlocal && set path_to_go=%path_to_go%

@cd /d %path_to_go%

