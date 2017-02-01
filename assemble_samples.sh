#!/bin/bash

# Requires metaflac, ffmpeg with libvorbis and lame.

mkdir -p samples

# Assemble FLAC sources
cp sample.flac samples/no_image.flac
cp sample.flac samples/large_image.flac
metaflac --import-picture-from=image_large.jpg samples/large_image.flac
cp sample.flac samples/small_image.flac
metaflac --import-picture-from=image_small.jpg samples/small_image.flac
cp sample.flac samples/tiny_image.flac
metaflac --import-picture-from=image_tiny.png samples/tiny_image.flac

cd samples

for file in *.flac; do
  ffmpeg -v quiet -y -i "${file}" -qscale:a 6 -map_metadata 0:g:0 "${file%.flac}.mp3"
  ffmpeg -v quiet -y -i "${file}" -codec:a libvorbis -qscale:a 6 -map_metadata 0 "${file%.flac}.ogg"
done
