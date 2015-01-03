class ListFile
  def get_full_path(dir)
    # dir the the rleative path to applications dir
    return File.join(Rails.root, 'app/assets/images',dir)  
  end 
  def get_dir_list(dir)
    dir=get_full_path(dir)
    Dir.entries(dir).select{|f| File.directory? f}

  end 
  def get_file_list(dir)
    dir=get_full_path(dir)
    Dir.entries(dir).select{|f| File.file? File.join(dir,f)}
  end 
end  
