class Module {
  final String title;
  final String subtitle;
  final int numVideos;
  final int length;

  final List<String> videoIds;
  final List<String> videoTitles;
  final List<String> videoMinutes;

  Module(
      this.title,
      this.subtitle,
      this.numVideos,
      this.length,
      this.videoIds,
      this.videoTitles,
      this.videoMinutes
      );
}

Module ghmpModule = Module(
  "Newborn Care Series",
  "Global Health Media Project",
  3,
  27,
  ["assets/20210216_164508.mp4", "assets/test.mp4", "assets/test.mp4"],
  [
    "Helping Babies Breathe at Birth",
    "Danger Signs in Newborns, for Health Workers",
    "Warning Signs in Newborns, for Mothers and Caregivers",
  ],
  ["9 min", "9 min", "9 min"],
);

Module garhModule = Module(
  "Neonatal Resuscitation",
  "GARH",
  2,
  16,
  [
    "assets/test.mp4",
    "assets/test.mp4",
  ],
  [
    "Full Term Newborn",
    "Preterm Newborn",
  ],
  ["8 min", "8 min"],
);


class Video{
  String? video_title;
  String? thumbnail_path;
  String? video_path;
  int? video_length;
  Video(this.video_title, this.thumbnail_path, this.video_path, this.video_length);
  static List<Video> video_List = [
      Video(
      "Full Term Newborn",
      "assets/Fullterm_thumbnail.jpg",
      "https://www.youtube.com/watch?v=jwnkRmzsiEg&feature=youtu.be&ab_channel=NeonatalResuscitationProgramGhanaGHS_Kybele",
      8,
    ),
    Video(
      "Preterm Newborn",
      "assets/Preterm_thumbnail.jpg",
      "https://www.youtube.com/watch?v=uuP-TmIBIfk&ab_channel=NeonatalResuscitationProgramGhanaGHS_Kybele",
      8,
    ),
  ];
}