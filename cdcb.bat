@rem
@rem  CD to the path that is in the clipboard
@rem
@rem  Needs paste.pl
@rem
@rem  Compare with cb.bat
@rem

@for /f "usebackq" %%n in (`paste`) do cd /d %%n
