import 'package:flutter/material.dart';


class MatchesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1D),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1D),
        elevation: 0,
        title: Text('Matches', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top Match Card
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.redAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'TEST',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.live_tv, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'Live Match',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        '  الترك للسلامة العامة',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Headingly',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTeamIcon('ENG'),
                          Text(
                            'ENG need 27 runs to win',
                            style: TextStyle(color: Colors.white),
                          ),
                          _buildTeamIcon('AUS'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Options List
              _buildOptionCard(Icons.calendar_today, 'Schedules'),
              _buildOptionCard(Icons.people, 'Teams'),
              _buildOptionCard(Icons.location_on, 'Venue'),
              _buildOptionCard(Icons.table_chart, 'Point Table'),
              _buildOptionCard(Icons.bar_chart, 'ODI Ranking'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamIcon(String teamCode) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Text(
            teamCode,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(IconData icon, String title) {
    return Card(
      color: Color(0xFF2D2D34),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () {
          // Add navigation logic here
        },
      ),
    );
  }
}
