enum LottieAnimation {
  empty(name: 'empty'),
  error(name: 'errror'),
  loading(name: 'loading'),
  search(name: 'search'),
  dataNot(name: 'dataNotFound'),
  small(name: 'smallError'),
  paymentfailed(name: 'paymentfailed'),
  realestate(name: 'realestate'),
  trying(name: 'trying'),
  nocart(name: 'emptycart');

  final String name;
  const LottieAnimation({required this.name});
}
