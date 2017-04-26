@rem
@rem  Use two parameters (percent1=percent2) because
@rem  the equal sign is treated as a seperator in cmd.exe.
@rem  Since youtube links always have an equal sign,
@rem  the original youtube link is constructed again.
@rem
youtube-dl --extract-audio --audio-format mp3 %1=%2
