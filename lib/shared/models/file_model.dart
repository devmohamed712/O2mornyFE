class FileModel {
  final Stream FileStream;
  final String FileName;

  FileModel({required this.FileStream, required this.FileName});

  Map<String, dynamic> toJson() {
    return {"FileStream": FileStream, "FileName": FileName};
  }
}
