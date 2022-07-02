import 'package:flutter/material.dart';

class CheckoutSteps extends StatefulWidget {
  const CheckoutSteps({Key? key}) : super(key: key);

  @override
  _CheckoutStepsState createState() => _CheckoutStepsState();
}

class _CheckoutStepsState extends State<CheckoutSteps> {
  int _activeStepIndex = 0;

  List<Step> stepList() => [
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.vertical,
      currentStep: _activeStepIndex,
      steps: stepList(),
      onStepContinue: () {
        if (_activeStepIndex < (stepList().length - 1)) {
          setState(() {
            _activeStepIndex += 1;
          });
        } else {
          print('Submitted');
        }
      },
      onStepCancel: () {
        if (_activeStepIndex == 0) {
          return;
        }

        setState(() {
          _activeStepIndex -= 1;
        });
      },
      onStepTapped: (int index) {
        setState(() {
          _activeStepIndex = index;
        });
      },
      controlsBuilder: (context, details) {
        final isLastStep = _activeStepIndex == stepList().length - 1;
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: details.onStepContinue,
                child: (isLastStep) ? const Text('Submit') : const Text('Next'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (_activeStepIndex > 0)
              Expanded(
                child: ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
              )
          ],
        );
      },
    );
  }
}
