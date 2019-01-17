@rem
@rem Put current path into clipboard.
@rem
@rem set /p in order to suppress
@rem newline of echo (https://stackoverflow.com/a/7105690/180275)
@rem
@echo | set /p="%CD%" | clip
