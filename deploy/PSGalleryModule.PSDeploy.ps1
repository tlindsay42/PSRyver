Deploy 'Module' {
    By 'PSGalleryModule' {
        FromSource $Env:BHProjectName
        To 'PSGallery'
        WithOptions @{
            ApiKey = $Env:NUGET_API_KEY
        }
    }
}
