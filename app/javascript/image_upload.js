// Prevent uploading of big images.
document.addEventListener("turbo:load", function() {
    console.log("this work")
    document.addEventListener("change", function(event) {
        let image_upload = document.querySelector('#avatar_edit');
        const size_in_megabytes = image_upload.files[0].size/1024/1024;
        if (size_in_megabytes > 5) {
            alert("Maximum file size is 5MB. Please choose a smaller file.");
            image_upload.value = "";
        }
    });
});