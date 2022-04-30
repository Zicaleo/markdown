// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../ast.dart';
import '../charcode.dart';
import 'link_syntax.dart';

/// Matches images like `![alternate text](url "optional title")` and
/// `![alternate text][label]`.
class VideoSyntax extends LinkSyntax {
  VideoSyntax({Resolver? linkResolver})
      : super(
          linkResolver: linkResolver,
          pattern: r'!\[video',
          startCharacter: $exclamation,
        );

  @override
  Element createNode(
    String destination,
    String? title, {
    required List<Node> Function() getChildren,
  }) {
    final children = getChildren();

    final source = Element.empty('source');
    source.attributes['src'] = destination;

    final element = Element('video', [source]);
    element.attributes['alt'] = children.map((node) => node.textContent).join();
    
    return element;
  }
}
