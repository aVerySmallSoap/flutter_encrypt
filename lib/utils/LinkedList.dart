import 'dart:io';

//I am reusing old C++ code for this LinkedList lol
//TODO: Write documentation
class Node<T> {
  T value;
  Node? next;
  Node(this.value);
}

class LinkedList<T> {
  Node<T>? head;
  Node<T>? tail;
  int size = 0;

  void display() {
    Node<T>? ptr = head;
    while (ptr?.next != null && ptr != tail) {
      T? val = ptr?.value;
      stdout.write("[$val]->");
      ptr = ptr?.next as Node<T>;
    }
    T? val = ptr?.value;
    T? hv = head?.value;
    print("[$val]->... $hv\n");
  }

  void insertFirst(T v) {
    Node<T> n = Node(v);
    if (this.head == null) {
      head = n;
      tail = n;
      ++size;
      return;
    }
    n.next = head;
    head = n;
    ++size;
  }

  void insertLast(T v) {
    Node<T> n = Node(v);
    if (this.head == null) {
      head = n;
      tail = n;
      ++size;
      return;
    }
    tail?.next = n;
    tail = n;
    n.next = head;
    ++size;
  }

  void insertAt(int i, T v) {
    Node<T> n = Node(v);
    if (this.head == null) {
      head = n;
      tail = n;
      ++size;
      return;
    }
    Node? ptr = head;
    for (int j = 0; j < i; ++j) {
      ptr = ptr?.next;
    }
    n.next = ptr?.next;
    ptr?.next = n;
    ++size;
  }

  void remove(T v) {
    Node? ptr = head;
    if (head == tail && head?.value == v) {
      head = null;
      tail = null;
      --size;
      return;
    }
    if (head?.value == v) {
      Node? n = head?.next;
      head = n as Node<T>?;
      tail?.next = head;
      return;
    }
    while (ptr?.next != null) {
      if (ptr?.next?.value == v) {
        ptr?.next = ptr.next?.next;
        return;
      }
      ptr = ptr?.next;
    }
    --size;
  }

  Node<T>? get(int i) {
    Node<T>? ptr = head;
    for (int j = 0; j < i; ++j) {
      ptr = ptr?.next as Node<T>;
    }
    return ptr;
  }

  //Converts a List of items into a LinkedList equivalent
  LinkedList<T> toLinked(List<T> arr) {
    LinkedList<T> list = LinkedList(); //implicit?
    for (int i = 0; i < arr.length; ++i) {
      list.insertLast(arr[i]);
    }
    return list;
  }

  //Converts a LinkedList to a List
  List<T> toList([LinkedList<T>? linked]) {
    linked ??= this;
    List<T> list = List.filled(linked.size, linked.head!.value);
    Node<T>? ptr = linked.head;
    for (int i = 0; i < linked.size; ++i) {
      list[i] = ptr!.value;
      ptr = ptr.next as Node<T>?;
    }
    return list;
  }
}
