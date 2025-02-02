## About

**Keep in mind. This package is currently in early stages of development. Any feedback or help is appreciated :)**

status_cubit is a lightweight package extending the functionality of the flutter_bloc package. 
The goal is to provide a simplest way as possible to manage simple async operations in your app.
For example, if you want to submit an form or load some data from your REST API or local DB, you
can use this package to manage the state of the operation and let you focus on the business logic.
This also helps you to keep your code clean without unnecessary boilerplate and easy to read.

## Usage

A simple usage example:

### 1. Define cubit with your business logic
You may do whatever you want in your cubit. The only thing you need to do is to emit the status 
of the operation the cubit is doing. In future, there is planned defined usecase addition for cubits
so you don't need to even define the cubits, only providing them with usecase containing business logic.

```dart
class MyCubit extends StatusCubit<SomeDataIFetch> {
  void load() async {
    emitLoading();
    ... do your business here
    if(success) {
      emitSuccess(data);
    } else {
      emitError('Error message');
    }
  }
}
```

### 2. Then use the StatusBlocListener or StatusBlocBuilder


#### StatusBlocListener
Wrap your widgets as you would do without StatusCubit. Only difference is using the StatusBlocListener.
The beauty of this is that you only tell what to happen in various scenarios and don't need to do any
clutter around to find out whether the status is failure or success. Otherwise, you would need to 
set the status in the state like with Enum or whole Class and then explicitly check for those values.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocProvider<MyCubit>(
      child: StatusBlocListener<MyCubit, SomeDataIFetch>(
        onLoading: (context) => showLoadingDialog(context),
        onError: (context, error) => showErrorMessage(context, error),
        onSuccess: (context, data) => showSuccessMessage(context, data),
        child: Column(
          children: [
          Text('Hello there'),
            ElevatedButton(
              onPressed: () => context.read<MyCubit>().load(),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
}
```

#### StatusBlocBuilder
The difference here apart from the StatusBlocListener is that you can return the widgets you want
based on the status. If you need to always return the same widget then create it as a new (stateless)
widget and provide it with parameters that this bloc builder will provide in various scenarios.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocProvider<MyCubit>(
      child: StatusBlocBuilder<MyCubit, SomeDataIFetch>(
        onLoading: (context) => CircularProgressIndicator(),
        onError: (context, error) => Text(error),
        onSuccess: (context, data) => Text(data),
        onDefault: (context) => Column(
          children: [
          Text('Hello there'),
            ElevatedButton(
              onPressed: () => context.read<MyCubit>().load(),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
}
```
