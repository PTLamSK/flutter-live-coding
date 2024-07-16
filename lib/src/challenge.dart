import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LiveCodingTestParentData extends ContainerBoxParentData<RenderBox> {}

class LiveCodingTest extends MultiChildRenderObjectWidget {
  final Alignment alignment;

  const LiveCodingTest({
    super.key,
    required super.children,
    this.alignment = Alignment.center,
  });

  @override
  RenderLiveCodingTest createRenderObject(BuildContext context) {
    return RenderLiveCodingTest(alignment);
  }

  @override
  void updateRenderObject(BuildContext context, RenderLiveCodingTest renderObject) {
    renderObject.alignment = alignment;
  }
}

class RenderLiveCodingTest extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, LiveCodingTestParentData>, RenderBoxContainerDefaultsMixin<RenderBox, LiveCodingTestParentData> {
  Alignment alignment;

  RenderLiveCodingTest(this.alignment);

  /// Must be override to use [LiveCodingTestParentData]
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! LiveCodingTestParentData) {
      child.parentData = LiveCodingTestParentData();
    }
  }

  @override
  void performLayout() {
    // Layout children widgets to get their `Size` values.
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as LiveCodingTestParentData?;
      child.layout(constraints.loosen(), parentUsesSize: true);
      child = childParentData?.nextSibling;
    }

    // Position each child within the `RenderLiveCodingTest` size based on it's `constraints`
    size = Size(constraints.maxWidth, constraints.maxHeight);
    child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as LiveCodingTestParentData?;
      final dx = (size.width - child.size.width) / 2 * (alignment.x + 1);
      final dy = (size.height - child.size.height) / 2 * (alignment.y + 1);
      childParentData?.offset = Offset(dx, dy);
      child = childParentData?.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as LiveCodingTestParentData?;
      context.paintChild(child, offset + (childParentData?.offset ?? Offset.zero));
      child = childParentData?.nextSibling;
    }
  }
}
