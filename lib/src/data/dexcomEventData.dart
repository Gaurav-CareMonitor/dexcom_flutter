import 'package:dexcom_flutter/src/utils/formats.dart';

import 'package:dexcom_flutter/src/data/dexcomData.dart';

///An enumerator for the type of event.
enum EventType{
  ///Carbohydrate intake.
  CARBS,

  ///Insulin injection.
  INSULIN,

  ///Physical activity.
  EXERCISE,

  ///Health-related events.
  HEALTH,
}// EventType

///An enumerator for the subtype of event.
enum EventSubtype{

  ///When [EventType] is [EventType.INSULIN]. Fast-acting insulin.
  FAST_ACTING,

  ///When [EventType] is [EventType.INSULIN]. Long-acting insulin.
  LONG_ACTING,

  ///When [EventType] is [EventType.EXERCISE]. Heavy intensity exercise.
  HEAVY,

  ///When [EventType] is [EventType.EXERCISE]. Medium intensity exercise.
  MEDIUM,

  ///When [EventType] is [EventType.EXERCISE]. Light intensity exercise.
  LIGHT,

  ///When [EventType] is [EventType.HEALTH]. Illness.
  ILLNESS,

  ///When [EventType] is [EventType.HEALTH]. Stress.
  STRESS,

  ///When [EventType] is [EventType.HEALTH]. High glycemia symptoms.
  HIGH_SYMPTOMS,

  ///When [EventType] is [EventType.HEALTH]. Low glycemia symptoms.
  LOW_SYMPTOMS,

  ///When [EventType] is [EventType.HEALTH]. Menstrual cycle.
  CYCLE,

  ///When [EventType] is [EventType.HEALTH]. Alcohol assumption.
  ALCOHOL,


}// EventSubtype

///An enumerator for the unit of measurement of the event.
enum EventUnit{

  ///When [EventType] is [EventType.CARBS]. Grams of carbohydrates.
  GRAMS,

  ///When [EventType] is [EventType.INSULIN]. Units of insulin.
  UNITS,

  ///When [EventType] is [EventType.EXERCISE]. Minutes of exercise.
  MINUTES,

}//EventUnit

///An enumerator for the status of the event.
enum EventStatus{

  ///When the event has been created and still present within trhe system.
  CREATED,

  ///When the event has been deleted.
  DELETED,

}//EventUnit


/// [DexcomEventData] is a class implementing the data model of the
/// user event log.
class DexcomEventData implements DexcomData {

  /// The type of [DexcomEventData].
  final EventType eventType;

  /// The time according to the system clock at which the [DexcomEventData] was recorded; nominally UTC.
  final DateTime systemTime;

  /// The time displayed on the receiving device when the [DexcomEventData] was recorded.
  final DateTime displayTime;

  /// The subtype of [DexcomEventData]. 
  final EventSubtype? eventSubtype;

  /// The value of input.
  final double? value;

  /// The unit of measurement of [DexcomEventData].
  final EventUnit? eventUnit;

  ///The ID of the [DexcomEventData].
  final String eventId;

  /// The status of the [DexcomEventData]. The G6 app enabled the ability to delete events after they have been created.
  /// To accomodate this, the [eventId] and [eventStatus] fields were introduced. When an event is initially created by 
  /// the user, the [eventStatus] is set to "created". If the user deletes the event, the [eventStatus] will be changed to 
  /// "deleted". The [eventId] will remain the same.
  /// For events generated by receiving devices that do not have the ability to delete events (such as the G4 and G5 apps), 
  /// the [eventStatus] field will always return "created".
  final EventStatus eventStatus;

  /// Default [DexcomEventData] constructor.
  DexcomEventData({
    required this.eventType,
    required this.systemTime,
    required this.displayTime,
    this.eventSubtype,
    this.value,
    this.eventUnit,
    required this.eventId,
    required this.eventStatus,
  });

  /// Generates a [DexcomEventData] obtained from a json.
  factory DexcomEventData.fromJson({required Map<String, dynamic> json}) {

    final EventType eventType;
    if(json['eventType'] == "carbs"){
      eventType = EventType.CARBS;
    } else if(json['eventType'] == "insulin"){
      eventType = EventType.INSULIN;
    }else if(json['eventType'] == "exercise"){
      eventType = EventType.EXERCISE;
    }else{
      eventType = EventType.HEALTH;
    }// if

    final EventSubtype? eventSubtype;
    if(json['eventSubtype'] == "fastActing"){
      eventSubtype = EventSubtype.FAST_ACTING;
    } else if(json['eventSubtype'] == "longActing"){
      eventSubtype = EventSubtype.LONG_ACTING;
    }else if(json['eventSubtype'] == "light"){
      eventSubtype = EventSubtype.LIGHT;
    }else if(json['eventSubtype'] == "medium"){
      eventSubtype = EventSubtype.MEDIUM;
    }else if(json['eventSubtype'] == "heavy"){
      eventSubtype = EventSubtype.HEAVY;
    }else if(json['eventSubtype'] == "illness"){
      eventSubtype = EventSubtype.ILLNESS;
    }else if(json['eventSubtype'] == "stress"){
      eventSubtype = EventSubtype.STRESS;
    }else if(json['eventSubtype'] == "highSymptoms"){
      eventSubtype = EventSubtype.HIGH_SYMPTOMS;
    }else if(json['eventSubtype'] == "lowSymptoms"){
      eventSubtype = EventSubtype.LOW_SYMPTOMS;
    }else if(json['eventSubtype'] == "cycle"){
      eventSubtype = EventSubtype.CYCLE;
    }else if(json['eventSubtype'] == "alcohol"){
      eventSubtype = EventSubtype.ALCOHOL;
    }else{
      eventSubtype = null;
    }// if

    final EventUnit? eventUnit;
    if(json['eventUnit'] == "grams"){
      eventUnit = EventUnit.GRAMS;
    } else if(json['eventUnit'] == "units"){
      eventUnit = EventUnit.UNITS;
    }else if(json['eventUnit'] == "minutes"){
      eventUnit = EventUnit.MINUTES;
    }else{
      eventUnit = null;
    }// if

    final EventStatus eventStatus;
    if(json['eventStatus'] == "created"){
      eventStatus = EventStatus.CREATED;
    }else{
      eventStatus = EventStatus.DELETED;
    }// if

    return DexcomEventData(
      eventType: eventType,
      eventSubtype: eventSubtype,
      systemTime: Formats.fullDateFormat.parse(json['systemTime']),
      displayTime: Formats.fullDateFormat.parse(json['displayTime']),
      value: json['value'] == null ? null : double.parse(json['value'].toString()),
      eventId: json['eventId'],
      eventUnit: eventUnit,
      eventStatus: eventStatus,
    );
  } // fromJson

  @override
  String toString() {
    
    return (StringBuffer('DexcomEventData(')
          ..write('eventType: $eventType, ')
          ..write('systemTime: $systemTime, ')
          ..write('displayTime: $displayTime, ')
          ..write('eventSubtype: $eventSubtype, ')
          ..write('value: $value, ')
          ..write('eventId: $eventId, ')
          ..write('eventUnit: $eventUnit, ')
          ..write('eventStatus: $eventStatus ')
          ..write(')'))
        .toString();
  } // toString

  @override
  Map<String, dynamic> toJson<T extends DexcomData>() {

    final String eventTypeStr;
    if(eventType == EventType.CARBS){
      eventTypeStr = "carbs";
    } else if(eventType == EventType.INSULIN){
      eventTypeStr = "insulin";
    }else if(eventType == EventType.EXERCISE){
      eventTypeStr = "exercise";
    }else{
      eventTypeStr = "health";
    }// if

    final String? eventSubtypeStr;
    if(eventSubtype == EventSubtype.FAST_ACTING){
      eventSubtypeStr = "fastActing";
    } else if(eventSubtype == EventSubtype.LONG_ACTING){
      eventSubtypeStr = "longActing";
    }else if(eventSubtype == EventSubtype.LIGHT){
      eventSubtypeStr = "light";
    }else if(eventSubtype == EventSubtype.MEDIUM){
      eventSubtypeStr = "medium";
    }else if(eventSubtype == EventSubtype.HEAVY){
      eventSubtypeStr = "heavy";
    }else if(eventSubtype == EventSubtype.ILLNESS){
      eventSubtypeStr = "illness";
    }else if(eventSubtype == EventSubtype.STRESS){
      eventSubtypeStr = "stress";
    }else if(eventSubtype == EventSubtype.HIGH_SYMPTOMS){
      eventSubtypeStr = "highSymptoms";
    }else if(eventSubtype == EventSubtype.LOW_SYMPTOMS){
      eventSubtypeStr = "lowSymptoms";
    }else if(eventSubtype == EventSubtype.CYCLE){
      eventSubtypeStr = "cycle";
    }else if(eventSubtype == EventSubtype.ALCOHOL){
      eventSubtypeStr = "alcohol";
    }else{
      eventSubtypeStr = null;
    }// if

    final String? eventUnitStr;
    if(eventUnit == EventUnit.GRAMS){
      eventUnitStr = "grams";
    } else if(eventUnit == EventUnit.UNITS){
      eventUnitStr = "units";
    }else if(eventUnit == EventUnit.MINUTES){
      eventUnitStr = "minutes";
    }else{
      eventUnitStr = null;
    }// if

    final String eventStatusStr;
    if(eventStatus == EventStatus.CREATED){
      eventStatusStr = "created";
    }else{
      eventStatusStr = "deleted";
    }// if

    return <String, dynamic>{
      'eventType': eventTypeStr,
      'systemTime' : Formats.fullDateFormat.format(systemTime),
      'displayTime' : Formats.fullDateFormat.format(displayTime),
      'eventSubtype' : eventSubtypeStr,
      'value' : value,
      'eventId' : eventId,
      'unit' : eventUnitStr,
      'eventStatus' : eventStatusStr
    };
  } // toJson

} // DexcomEventData