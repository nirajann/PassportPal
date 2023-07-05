import 'package:flutter/material.dart';

class UniProcess extends StatefulWidget {
  const UniProcess({super.key});

  @override
  State<UniProcess> createState() => _UniProcessState();
}

class _UniProcessState extends State<UniProcess> {
  int currentStep = 0;

  List<Step> steps = [
    const Step(
      title: Text('Step 1'),
      content: Text('Visit university website and locate admissions section.'),
    ),
    const Step(
      title: Text('Step 2'),
      content:
          Text('Create an account or login to the online application portal.'),
    ),
    const Step(
      title: Text('Step 3'),
      content: Text('Fill in your personal details.'),
    ),
    const Step(
      title: Text('Step 4'),
      content: Text('Enter your educational background.'),
    ),
    const Step(
      title: Text('Step 5'),
      content: Text(
          'Provide details about your intended major or program of study.'),
    ),
    const Step(
      title: Text('Step 6'),
      content: Text('Upload supporting documents.'),
    ),
    const Step(
      title: Text('Step 7'),
      content: Text('Pay the application fee.'),
    ),
    const Step(
      title: Text('Step 8'),
      content: Text('Submit your application.'),
    ),
  ];

  void goToNextStep() {
    setState(() {
      currentStep < steps.length - 1 ? currentStep++ : currentStep = 0;
    });
  }

  Widget _buildControls(BuildContext context, ControlsDetails controlsDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: controlsDetails.onStepContinue,
            child: Text(currentStep == steps.length - 1 ? 'Submit' : 'Next'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('University Application Process'),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: goToNextStep,
        steps: steps,
        controlsBuilder: _buildControls,
      ),
    );
  }
}
