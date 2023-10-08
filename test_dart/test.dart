import 'dart:convert';

void main() {
  String query = "Test";

  Map<String, dynamic> data = {
    "isSuccess": true,
    "data": [
      {
        "_id": "64efd37dad47b7f19d78029c",
        "eventId": {
          "is_success": true,
          "event_id": "FB10100000001693438844#8169327",
          "inserted_id": "64efd37cad47b7f19d78029b"
        },
        "DowellGroup": {
          "group_name": "Sample Group 2",
          "user_id": "456",
          "created_by": "worlako",
          "org_id": "6390b313d77dc467630713f2",
          "org_name": "worlako",
          "created_at_position": "my-channel-app",
          "email_list": ["sample1@gmail.com", "sample2@gmail.com"],
          "created_at": "2023-08-30T23:40:19.077782",
          "deleted": false
        }
      },
      {
        "_id": "64efd37dad47b7f19d78029c",
        "eventId": {
          "is_success": true,
          "event_id": "FB10100000001693438844#8169327",
          "inserted_id": "64efd37cad47b7f19d78029b"
        },
        "DowellGroup": {
          "group_name": "Sample 2 Test",
          "user_id": "456",
          "created_by": "worlako",
          "org_id": "6390b313d77dc467630713f2",
          "org_name": "worlako",
          "created_at_position": "my-channel-app",
          "email_list": ["sample1@gmail.com", "sample2@gmail.com"],
          "created_at": "2023-08-30T23:40:19.077782",
          "deleted": false
        }
      },
      {
        "_id": "64efd6fdad47b7f19d7802a4",
        "eventId": {
          "is_success": true,
          "event_id": "FB10100000001693439741#0050406",
          "inserted_id": "64efd6fdad47b7f19d7802a3"
        },
        "DowellGroup": {
          "group_name": "Sample Group 3 Test",
          "user_id": "456",
          "created_by": "worlako",
          "org_id": "6390b313d77dc467630713f2",
          "org_name": "worlako",
          "created_at_position": "my-channel-app",
          "email_list": ["sample1@gmail.com", "sample2@gmail.com"],
          "created_at": "2023-08-30T23:55:15.367242",
          "deleted": false
        }
      },
      {
        "_id": "64efda737fedf01bfb8d95bb",
        "eventId": {
          "is_success": true,
          "event_id": "FB101000000001693440627#568946",
          "inserted_id": "64efda737fedf01bfb8d95ba"
        },
        "DowellGroup": {
          "group_name": "Sample Group 4",
          "user_id": "456",
          "created_by": "worlako",
          "org_id": "6390b313d77dc467630713f2",
          "org_name": "worlako",
          "created_at_position": "my-channel-app",
          "email_list": ["sample1@gmail.com", "sample2@gmail.com"],
          "created_at": "2023-08-31T00:10:27.567856",
          "deleted": false
        }
      },
      {
        "_id": "64f4c88b56531a1d9d89c247",
        "eventId": {
          "is_success": true,
          "event_id": "FB101000000001693763723#609613",
          "inserted_id": "64f4c88b19060c50a85115ff"
        },
        "DowellGroup": {
          "group_name": "Sample  5",
          "user_id": "456",
          "created_by": "worlako",
          "org_id": "6390b313d77dc467630713f2",
          "org_name": "worlako",
          "created_at_position": "my-channel-app",
          "email_list": ["sample1@gmail.com", "sample2@gmail.com"],
          "created_at": "2023-09-03T17:55:23.587512",
          "deleted": false
        }
      }
    ]
  };

  searchGroupsV1(query, data);
}

void searchGroupsV1(String query, Map<String, dynamic> jsonData) {
  final List<dynamic> data = jsonData['data'];

  // Filter the data list based on the query
  List<dynamic> filteredGroups = data.where((group) {
    Map<String, dynamic>? groupMap = group as Map<String, dynamic>?;
    String? groupName =
        groupMap?["DowellGroup"]?["group_name"]?.toString().toLowerCase();
    return groupName?.contains(query.toLowerCase()) ?? false;
  }).toList();

  // Do something with the filteredGroups, such as updating the UI
  // or storing the results in a new variable.

  print(filteredGroups);
}

void searchGroups(String query) {
  final data = [
    {
      "_id": "64f6a77af8366cc1a22dcf28",
      "eventId": {
        "is_success": true,
        "event_id": "FB10100000001693886329#7180665",
        "inserted_id": "64f6a779492215a52e7af11b"
      },
      "DowellGroup": {
        "group_name": "Group Dev UPDATED",
        "user_id": "6390b31ed77dc467630713f9",
        "created_by": "WorkflowAi",
        "org_id": "6390b313d77dc467630713f2",
        "org_name": "HR_Dowell Research",
        "created_at_position": "my-channel-app",
        "email_list": ["dev1@gmail.com", "dev2@gmail.com"],
        "created_at": "2023-09-05T03:58:49.712704",
        "deleted": false
      }
    },
    {
      "_id": "64f6b88fc4a02ffba74d19d7",
      "eventId": {
        "is_success": true,
        "event_id": "FB10100000001693890703#0615413",
        "inserted_id": "64f6b88fb3cf55be27eed82c"
      },
      "DowellGroup": {
        "group_name": "Group Marketing. UPDATED",
        "user_id": "6390b31ed77dc467630713f9",
        "created_by": "WorkflowAi",
        "org_id": "6390b313d77dc467630713f2",
        "org_name": "HR_Dowell Research",
        "created_at_position": "my-channel-app",
        "email_list": ["user3@gmail.com", "user1@gmail.com"],
        "created_at": "2023-09-05T05:11:43.054226",
        "deleted": false
      }
    },
    {
      "_id": "64f6b88fc4a02ffba74d19d7",
      "eventId": {
        "is_success": true,
        "event_id": "FB10100000001693890703#0615413",
        "inserted_id": "64f6b88fb3cf55be27eed82c"
      },
      "DowellGroup": {
        "group_name": "Marketing. UPDATED",
        "user_id": "6390b31ed77dc467630713f9",
        "created_by": "WorkflowAi",
        "org_id": "6390b313d77dc467630713f2",
        "org_name": "HR_Dowell Research",
        "created_at_position": "my-channel-app",
        "email_list": ["user3@gmail.com", "user1@gmail.com"],
        "created_at": "2023-09-05T05:11:43.054226",
        "deleted": false
      }
    }
  ];

  // Filter the data list based on the query
  List<dynamic> filteredGroups = data.where((group) {
    Map<String, dynamic>? groupMap = group;
    String? groupName =
        groupMap["DowellGroup"]?["group_name"]?.toString().toLowerCase();
    return groupName?.contains(query.toLowerCase()) ?? false;
  }).toList();

  print(filteredGroups);

  // Do something with the filteredGroups, such as updating the UI
  // or storing the results in a new variable.
}
