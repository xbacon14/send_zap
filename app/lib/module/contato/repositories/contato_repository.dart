class ContatoRepository {
  // Future<List<Contato>> findContatos() async {
  //   List<Contato> list = [];
  //   CollectionReference contatos = await firestore.collection('Contatos');
  //   contatos.get().then((value) {
  //     value.docs.forEach((element) {
  //       try {
  //         list.add(element.data() as Contato);
  //       } catch (e) {}
  //     });
  //   });
  //   return list;
  // }

  // Future<String?> saveContato({required Contato contato}) async {
  //   CollectionReference contatos = await firestore.collection('Contatos');
  //   return contatos.add(contato.toJson()).then((value) => value.id);
  // }
}
