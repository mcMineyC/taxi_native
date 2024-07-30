import "package:freezed_annotation/freezed_annotation.dart";

part "checklist_item.freezed.dart";
part "checklist_item.g.dart";

@freezed
class ChecklistItem with _$ChecklistItem {
  const ChecklistItem._();

  const factory ChecklistItem({
    required int id,
    required String name,
    required bool completed,
    required String requestedBy,
  }) = _ChecklistItem;
  factory ChecklistItem.empty() => ChecklistItem(
        id: -1,
        name: "",
        completed: false,
        requestedBy: "",
      );
  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}
