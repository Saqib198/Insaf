import 'package:flutter/material.dart';

class Document {
  final String title;
  late final String remarks;

  Document({required this.title, required this.remarks});
}

class FileChecking extends StatefulWidget {
  _FileCheckingState createState() => _FileCheckingState();
}

class _FileCheckingState extends State<FileChecking> {
  String _selectedVehicleType='Local';
  TextEditingController _saleCertificateController = TextEditingController();
  TextEditingController _saleInvoiceController = TextEditingController();
  TextEditingController _cancelBookController = TextEditingController();
  TextEditingController _bankNocController = TextEditingController();
  TextEditingController _companyNocController = TextEditingController();
  TextEditingController _cnicCopyController = TextEditingController();
  TextEditingController _cancelCardController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();

  TextEditingController _billOfEntryController = TextEditingController();
  TextEditingController _billOfLandingController = TextEditingController();
  TextEditingController _japaneseCertificateController = TextEditingController();
  TextEditingController _passportCopyController = TextEditingController();
  TextEditingController _importCertificateController = TextEditingController();
  TextEditingController _custromerVerificationLetterController = TextEditingController();


  @override
  void dispose() {
    _saleCertificateController.dispose();
    _saleInvoiceController.dispose();
    _cancelBookController.dispose();
    _bankNocController.dispose();
    _companyNocController.dispose();
    _cnicCopyController.dispose();
    _cancelCardController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Form'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedVehicleType,
                decoration: InputDecoration(labelText: 'Vehicle Type',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,

                ),
                items: ['Local', 'Import']
                    .map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVehicleType = value!;
                  });
                },
              ),
              if (_selectedVehicleType == 'Local') ...[
                _buildFormField('Sale Certificate', _saleCertificateController),
                _buildFormField('Sale Invoice', _saleInvoiceController),
                _buildFormField('Cancel Book', _cancelBookController),
                _buildFormField('Bank NOC', _bankNocController),
                _buildFormField('Company NOC', _companyNocController),
                _buildFormField('CNIC Copy', _cnicCopyController),
                _buildFormField('Cancel Card', _cancelCardController),
              ],
              if (_selectedVehicleType == 'Import') ...[
                _buildFormField('Bill of Entry', _billOfEntryController),
                _buildFormField('Bill of Landing', _billOfLandingController),
                _buildFormField('Japanese Certificate', _japaneseCertificateController),
                _buildFormField('Passport Copy', _passportCopyController),
                _buildFormField('Import Certificate', _importCertificateController),
                _buildFormField('Cancel Book', _cancelBookController),
                _buildFormField('Cancel Card', _cancelCardController),
                _buildFormField('Custromer Verification Letter', _custromerVerificationLetterController),
              ],
              TextFormField(
                controller: _remarksController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Remarks',
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 18.0)),
          ),

          Expanded(
            flex: 2,
            child:TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}