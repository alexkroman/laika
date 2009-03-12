class XDSUtils
  
  def self.retrieve_document(metadata)
    req = XDS::RetrieveDocumentSetRequest.new(XDS_REGISTRY_URLS[:retrieve_document_set_request])
    req.add_ids_to_request(metadata.repository_unique_id,metadata.unique_id)
    docs = req.execute
    if docs
      file_data = {"content_type"=>metadata.mime_type,
                   "size"=>metadata.size,
                   "filename"=>"registry_file",
                   "tempfile"=>StringIO.new(docs[0][:content])}
      return file_data
    end
  end
  
  
end