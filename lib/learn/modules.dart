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
  ["0clo9Lvpv7Y ", "ne06nPIKTmE", "Wg-k-BlG0r0"],
  [
    "Helping Babies Breathe at Birth",
    "Danger Signs in Newborns, for Health Workers",
    "Warning Signs in Newborns, for Mothers and Caregivers",
  ],
  ["9 min", "9 min", "9 min"],
);

Module garhModule = Module(
  "Neonatal Resuscitation Program",
  "GARH",
  2,
  16,
  [
    "uuP-TmIBIfk",
    "jwnkRmzsiEg",
  ],
  [
    "Full Term Newborn",
    "Preterm Newborn",
  ],
  ["8 min", "8 min"],
);