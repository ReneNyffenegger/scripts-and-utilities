@rem
@rem    cdms SomeTag
@rem
@rem    Associate the current directory with «SomeTag». Later, go back
@rem    to this directory with
@rem
@rem       cmd SomeTag
@rem
@rem
@set mark=%1

@if not defined mark (
  @echo you must specify a mark
  @exit /b
)

@set cd_mark_%mark%=%cd%
