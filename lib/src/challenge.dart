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
  final _children = <RenderBox>[];

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
      _children.add(child);
      final childParentData = child.parentData as LiveCodingTestParentData?;
      child.layout(constraints.loosen(), parentUsesSize: true);
      child = childParentData?.nextSibling;
    }

    // Sort children by size
    _children.sort((a, b) {
      final sizeA = a.size;
      final sizeB = b.size;

      return (sizeB.width * sizeB.height).compareTo(sizeA.width * sizeA.height);
    });

    // Position each child within the `RenderLiveCodingTest` size based on `constraints`
    size = Size(constraints.maxWidth, constraints.maxHeight);
    for (final child in _children) {
      final childParentData = child.parentData as LiveCodingTestParentData?;
      final dx = (size.width - child.size.width) / 2 * (alignment.x + 1);
      final dy = (size.height - child.size.height) / 2 * (alignment.y + 1);
      childParentData?.offset = Offset(dx, dy);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    for (final child in _children) {
      final childParentData = child.parentData as LiveCodingTestParentData?;
      context.paintChild(child, offset + (childParentData?.offset ?? Offset.zero));
    }
  }
}
