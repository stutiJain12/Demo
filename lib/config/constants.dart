class AppConstants {
  static const String baseUrl = 'https://6943bf647dd335f4c35df148.mockapi.io';
  static const String usersEndpoint = '$baseUrl/userlist';
  static const String addUserEndpoint = '$baseUrl/userlist';
  
  // Method to get single user endpoint or delete/update
  static String userDetailEndpoint(String id) => '$baseUrl/userlist/$id';

  static const List<Map<String, dynamic>> accordionItems = [
    {
      'title': 'Item 1',
      'content':
          'This is the detailed description for Item 1. You can add more information here about this item.',
    },
    {
      'title': 'Item 2',
      'content':
          'Detailed content for Item 2 goes here. Feel free to include longer text or even multiple paragraphs.',
    },
    {
      'title': 'Item 3',
      'content':
          'Here is some information about Item 3. Expansion panels are great for FAQs or settings.',
    },
    {
      'title': 'Item 4',
      'content':
          'Item 4 description. You can customize icons, colors, and styling.',
    },
    {
      'title': 'Item 5',
      'content':
          'More details about Item 5. Supports rich text if needed.',
    }
  ];
}
