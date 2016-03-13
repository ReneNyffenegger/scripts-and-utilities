@rem
@rem  Ask for the Password if it
@rem  is not already set:
@rem

@if [%TQ84_GITHUB_PW%] EQU [] (
  @set /p TQ84_GITHUB_PW=TQ84_GITHUB_PW? 
)

@git-push.pl
