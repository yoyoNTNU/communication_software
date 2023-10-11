part of 'group_widget.dart';

class StepProgressIndicator extends StatefulWidget {
  final int currentStep;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
  });

  @override
  State<StepProgressIndicator> createState() => _StepProgressIndicatorState();
}

class _StepProgressIndicatorState extends State<StepProgressIndicator> {
  int stepCircle = 0;
  int stepLine = 0;
  @override
  Widget build(BuildContext context) {
    if (stepCircle == 1 && stepCircle != widget.currentStep) {
      setState(() {
        stepCircle = widget.currentStep;
      });
    }
    if (stepLine == 0 && stepLine != widget.currentStep) {
      setState(() {
        stepLine = widget.currentStep;
      });
    }
    return SizedBox(
      height: 52,
      width: 223,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyle.teal,
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 144,
                    height: 5,
                    color: AppStyle.gray,
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: stepLine == 0 ? 0 : 144,
                    height: 5,
                    color: AppStyle.teal,
                    onEnd: () {
                      if (stepCircle == 0) {
                        setState(() {
                          stepCircle = widget.currentStep;
                        });
                      }
                    },
                  )
                ],
              ),
              AnimatedContainer(
                width: 16,
                height: 16,
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: stepCircle == 0 ? AppStyle.gray : AppStyle.teal,
                ),
                onEnd: () {
                  if (stepLine == 1) {
                    setState(() {
                      stepLine = widget.currentStep;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "選擇成員",
                style: AppStyle.caption(color: AppStyle.teal),
              ),
              Text(
                "編輯資料",
                style: AppStyle.caption(
                    color: stepCircle == 1 ? AppStyle.teal : AppStyle.gray),
              )
            ],
          )
        ],
      ),
    );
  }
}