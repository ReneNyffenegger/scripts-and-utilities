@set mark=%1

@if not defined mark (
  @echo you must specify a mark
  @exit /b
)

@set cd_mark_%mark%=%cd%
