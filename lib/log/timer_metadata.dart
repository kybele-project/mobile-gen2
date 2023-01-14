import 'package:intl/intl.dart';

// DISPLAY FORMATTING
NumberFormat timerNumberFormat = NumberFormat("00");

// STATES
enum TimerStatus {
  ready,
  started,
  paused,
  resumed,
  stopped,
}

// TIMER STAGE INFORMATION
// Location of stage boundaries in seconds (0, 1, 2, 3, 4, 5, 10, 15 min)
List<num> timerLocations = [0, 60, 120, 180, 240, 300, 600]; // Leaving off 900 seconds for now

// nextStageLocation = timerLocation[index] + timerGap[index]
List<num> timerGaps = [60, 60, 60, 60, 60, 300, 300];

// MESSAGE STRINGS
String timerStartedMessage = 'Timer assistant started';
String timerPausedMessage = 'Timer assistant paused';
String timerStoppedMessage = 'Press play to start timer assistant';
String timerResumedMessage = 'Timer assistant resumed';

List<String> timerActiveMessages = [
  '1 minute elapsed. Log APGAR score and oxygen saturation',
  '2 minutes elapsed. Log oxygen saturation',
  '3 minutes elapsed. Log oxygen saturation',
  '4 minutes elapsed. Log oxygen saturation',
  '5 minutes elapsed. Log APGAR score and oxygen saturation',
  '10 minutes elapsed. Log APGAR score and oxygen saturation',
  '15 minutes elapsed. Log APGAR score and oxygen saturation',
];

// AUDIO ASSET STRINGS
String timerStartedAudio = 'assets/timer_audio/timerStarted.wav';
String timerPausedAudio = 'assets/timer_audio/timerPaused.wav';
String timerStoppedAudio = 'assets/timer_audio/timerStopped.wav';
String timerResumedAudio = 'assets/timer_audio/timerResumed.wav';

List<String> timerActiveAudio = [
  'assets/timer_audio/timer1.wav',
  'assets/timer_audio/timer2.wav',
  'assets/timer_audio/timer3.wav',
  'assets/timer_audio/timer4.wav',
  'assets/timer_audio/timer5.wav',
  'assets/timer_audio/timer10.wav',
  'assets/timer_audio/timer15.wav',
];
