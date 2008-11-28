class LibraryWorker < BackgrounDRb::MetaWorker
  set_worker_name :library_worker
  
  def create(args = nil)
    # this method is called, when worker is loaded for the first time
    @ffmpeg = ENV['VOD_FFMPEG_LOC']
    cache[:status] = 'Inactive'
  end

  def generate_thumbnails(videos)
    logger.info "Generating missing thumbnails in library"
    cache[:status] = "Generating thumbnails"
    #videos = Video.find_all_by_thumbnail_loc(nil)
    target_path = "#{RAILS_ROOT}/public/images/thumbnails"
    videos.each do |video|
      file = RVideo::Inspector.new(:file => "#{video.library.path}/#{video.path}")
      file.capture_frame('1%', "#{target_path + '/' + video.id.to_s}.jpg")
    end
  end

  def load_video_info(videos)
    logger.info "Loading info for videos in library"
    cache[:status] = "Loading video info"
    #videos = Video.find_all_by_thumbnail_loc(nil)
    videos.each do |video|
      file = RVideo::Inspector.new(:file => "#{video.library.path}/#{video.path}")
      video.length = file.duration
      video.width = file.width
      video.height = file.height
      video.fps = file.fps
      video.save!
    end
  end

  def build_library(library_id)
    cache[:status] = "Building library: #{library_id}"
    library = Library.find(library_id)
    videos = library.videos
    videos.destroy_all unless videos.nil?
    d = Dir.entries(library.path)
    extensions = ['mpg','avi','divx']
    d.each do |file|
      if (extensions.any? {|ext| file[-3,3] == ext})
        video = library.videos.create(:name => file.to_s[0..-5], :desc => '', :path => file.to_s)
        video.save!
      end
    end
    library = Library.find(library_id)
    videos = library.videos
    if !videos.nil?
      load_video_info(videos)
      videos = library.videos
      generate_thumbnails(videos)
    end
    cache[:status] = 'Inactive'
  end
end

