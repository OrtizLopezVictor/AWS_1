class User {
  final String name;
  final String email;
  final String employeeId;
  final String position;
  final String department;
  final String? profileImage;

  User({
    required this.name,
    required this.email,
    required this.employeeId,
    required this.position,
    required this.department,
    this.profileImage,
  });
}

final User currentUser = User(
  name: 'Juan Pérez',
  email: 'juan.perez@empresa.com',
  employeeId: 'EMP-2045',
  position: 'Operador de Almacén',
  department: 'Logística',
  profileImage: null,
);
