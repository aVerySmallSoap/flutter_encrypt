import 'package:test_app/utils/linked_List.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test for linked_List.dart', () {
    test('toList should return a List of items from the LinkedList', () {
      LinkedList<String> list = LinkedList();
      list.insertLast('A');
      list.insertLast('B');
      list.insertLast('C');
      expect(list.toList(), <String>['A', 'B', 'C']);
    });

    test('toLinked should return a LinkedList from a List', () {
      LinkedList<String> list = LinkedList();
      LinkedList<String> expected = LinkedList();
      List<String> arr = ['A', 'B', 'C'];
      list = list.toLinked(arr);
      List<Node<String>>? act;
      List<Node<String>>? mat;
      expected.insertLast('A');
      expected.insertLast('B');
      expected.insertLast('C');
      Node<String>? ptr;
      for (int i = 0; i < list.size - 1; ++i) {
        (i == 0) ? ptr = list.head : ptr;
        act?[i] = ptr!;
        ptr = ptr?.next as Node<String>?;
      }
      for (int i = 0; i < expected.size - 1; ++i) {
        (i == 0) ? ptr = expected.head : ptr;
        mat?[i] = ptr!;
        ptr = ptr?.next as Node<String>?;
      }
      expect(act, mat);
    });

    test('insertFirst should insert at the head of the list', () {
      LinkedList<String> list = LinkedList();
      list.insertFirst('Hello');
      expect(list.head?.value, 'Hello');
      list.insertFirst('World');
      expect(list.head?.value, 'World');
      expect(list.tail?.value, 'Hello'); // Tail should still be hello
    });

    test('insertLast should insert at the tail of the list', () {
      LinkedList<String> list = LinkedList();
      list.insertLast('World');
      expect(list.tail?.value, 'World');
      expect(list.head?.value, 'World');
      list.insertFirst('Hello');
      expect(list.head?.value, 'Hello'); // Should be the head
    });

    test('get should return a node from a specified index', () {
      LinkedList<String> list = LinkedList();
      list.insertLast('A');
      Node<String> mat = Node('A');
      expect(list.get(0)!.value, mat.value);
    });
  });
}
