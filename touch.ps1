param (
   [string[]] $fileList
)

set-strictMode -version 3

foreach ($fileName in $fileList) {
   if (test-path $fileName) {
      $file = get-item $fileName
      $file.lastAccessTime = get-date
      $file.lastWriteTime  = $file.lastAccessTime
   }
   else {
      new-item $fileName
   }
}
