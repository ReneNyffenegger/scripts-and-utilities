@rem
@rem     Execute content of clipboard in cmd.exe
@rem     Compare with cdcb
@rem

@for /f "usebackq delims=#" %%n in (`paste`) do @cmd /c %%n

