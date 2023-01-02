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
  ["assets/20210216_164508.mp4", "assets/React App - Google Chrome 2021-02-16 14-36-45.mp4", "assets/React App - Google Chrome 2021-02-16 14-36-45.mp4"],
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
    "assets/React App - Google Chrome 2021-02-16 14-36-45.mp4",
    "assets/React App - Google Chrome 2021-02-16 14-36-45.mp4",
  ],
  [
    "Full Term Newborn",
    "Preterm Newborn",
  ],
  ["8 min", "8 min"],
);