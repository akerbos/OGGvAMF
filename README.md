# OGGvAMF

I noticed that when I converted FLAC music with cover images into OGG,
they wouldn't play on my smartphone anymore.
After corresponding with the author of my music player app,
I decided to create a small test suite to investigate.

Re-compile the samples using `assemble_samples.sh` (note the requirements).
In addition, create the `_ET` files by adding the respective images to 
`no_image.ogg` using easyTag.

Here are the results:

| File               | Mimetype           | AMF | VLC |
|--------------------|--------------------|-----|-----|
| large_image.flac   | audio/flac         | ✓    | ✓     |
| large_image.mp3    | audio/mpeg         | ✓    | ✓     |
| large_image.ogg    | video/x-theora+ogg | ❌     | ✓     |
| large_image_ET.ogg | audio/x-theora+ogg | ✓    | ✓     |
| no_image.flac      | audio/flac         | ✓    | ✓     |
| no_image.mp3       | audio/mpeg         | ✓    | ✓     |
| no_image.ogg       | audio/x-vorbis+ogg | ✓    | ✓     |
| small_image.flac   | audio/flac         | ✓    | ✓     |
| small_image.mp3    | audio/mpeg         | ✓    | ✓     |
| small_image.ogg    | video/x-theora+ogg | ❌     | ✓     |
| small_image_ET.ogg | audio/x-theora+ogg | ✓    | ✓     |
| tiny_image.flac    | audio/flac         | ✓    | ✓     |
| tiny_image.mp3     | audio/mpeg         | ✓    | ✓     |
| tiny_image.ogg     | video/x-theora+ogg | ❌     | ✓     |
| tiny_image_ET.ogg  | audio/x-theora+ogg | ✓    | ✓     |

Mimetype derived using `mimetype`. 
Note that ffmpeg-built OGGs with image resolve to video!

Tried playing with Music Folder Player which uses Android Media Framework (AMF)
and VLC. 
We note that AMF does not play ffmpeg-create OGGs with image, 
but it does the easyTag-tagged.
VLC plays everything.

Ffmpeg-created OGGs do not carry the image; not even VLC shows them!

Another observation ID3 tags of ffmpeg-created OGGs with image seem to be broken 
on AMF;
VLC has no problem.

### Summary

It seems that ffmpeg or libvorbis have a problem,
or my parameters `-codec:a libvorbis -qscale:a 6 -map_metadata 0` are somehow bad.

I posted a [question on unix.SE](http://unix.stackexchange.com/q/341857/17409).

### Parameters

~~~
easytag      2.4.2
ffmpeg       2.8.10
lame         3.99.5
libvorbis0a  1.3.5
metaflac     1.3.1
mimetype     0.27
~~~

### Credits

Example files from [publicdomainproject.org](https://pool.publicdomainproject.org/index.php/Africavox-dg1-ax98).
