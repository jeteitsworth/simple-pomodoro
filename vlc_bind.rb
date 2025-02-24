require 'ffi'

module VLC
	extend FFI::Library
	ffi_lib "C:\\Program Files\\VideoLAN\\VLC\\libvlc.dll"

	attach_function :libvlc_new, [:int, :pointer], :pointer
  	attach_function :libvlc_media_new_path, [:pointer, :string], :pointer
  	attach_function :libvlc_media_player_new_from_media, [:pointer], :pointer
  	attach_function :libvlc_media_player_play, [:pointer], :int
  	attach_function :libvlc_media_release, [:pointer], :void
  	attach_function :libvlc_media_player_release, [:pointer], :void
  	attach_function :libvlc_release, [:pointer], :void

  	# Stop and cleanup
  	attach_function :libvlc_media_player_stop, [:pointer], :void
  end