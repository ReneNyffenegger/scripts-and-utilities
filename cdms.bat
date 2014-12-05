@rem
@rem    cdms SomeTag
@rem
@rem    Associate the current directory with «SomeTag». Later, go back
@rem    to this directory with
@rem
@rem       cmd SomeTag
@rem
@rem
@set tq84_mark=%1

@if not defined tq84_mark (
  @echo you must specify a mark
  @exit /b
)

@set tq84_cd_mark_%tq84_mark%=%cd%
