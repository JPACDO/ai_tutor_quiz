import 'package:ai_tutor_quiz/domain/entities/entities.dart';
import 'package:ai_tutor_quiz/domain/use_cases/use_case.dart';
import 'package:ai_tutor_quiz/infrastructure/repositories/repositories.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'group_question_provider.g.dart';

// REPOSITORIES ---------------------------------------------------------------
@riverpod
GroupQuestionsRepositoryImpl groupQuestionRepository(
    GroupQuestionRepositoryRef ref) {
  final localDatasource = ref.read(isarDatasourceProvider);

  return GroupQuestionsRepositoryImpl(localDatasource);
}

// USE CASES -------------------------------------------------------------------
@riverpod
GetAllGroupQuestionsUseCase getAllGroupQuestions(GetAllGroupQuestionsRef ref) {
  final groupRepository = ref.read(groupQuestionRepositoryProvider);

  return GetAllGroupQuestionsUseCase(groupRepository);
}

@riverpod
AddNewGroupQuestionsUseCase createGroupQuestion(CreateGroupQuestionRef ref) {
  final groupRepository = ref.read(groupQuestionRepositoryProvider);

  return AddNewGroupQuestionsUseCase(groupRepository);
}

@riverpod
AddQuestionInGoroupUseCase addQuestionInGroup(AddQuestionInGroupRef ref) {
  final groupRepository = ref.read(groupQuestionRepositoryProvider);

  return AddQuestionInGoroupUseCase(groupRepository);
}

@riverpod
DeleteQuestionOfGoroupUseCase deleteQuestionOfGroup(
    DeleteQuestionOfGroupRef ref) {
  final groupRepository = ref.read(groupQuestionRepositoryProvider);

  return DeleteQuestionOfGoroupUseCase(groupRepository);
}

// GROUP QUESTION PROVIDER / FAVORITES -----------------------------------------
@riverpod
class GroupQuestion extends _$GroupQuestion {
  @override
  List<GroupQuestions> build() {
    return [];
  }

  void getAllGroup({required String userId}) async {
    state = [...await ref.read(getAllGroupQuestionsProvider)(data: userId)];
  }

  void createGroup(GroupQuestions groupQuestion) async {
    final result = await ref.read(createGroupQuestionProvider).call(
          data: groupQuestion,
        );

    state = [...state, result];
  }

  Future<bool> insertQuestion(
      {required Question question, required String groupId}) async {
    try {
      final result = await ref
          .read(addQuestionInGroupProvider)
          .call(data: question.copyWith(id: null), groupId: groupId);

      final newState = state
          .map((groupQuestion) => groupQuestion.id == groupId
              ? groupQuestion.copyWith(
                  id: groupQuestion.id,
                  questions: [...groupQuestion.questions, result])
              : groupQuestion)
          .toList();
      state = [...newState];

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteQuestion(
      {required String groupId, required String questionId}) async {
    final result = await ref
        .read(deleteQuestionOfGroupProvider)
        .call(data: questionId, groupId: groupId);

    if (!result) return false;

    final newState = state
        .map((groupQuestion) => groupId == groupQuestion.id
            ? groupQuestion.copyWith(
                questions: groupQuestion.questions
                    .where((element) => element.id != questionId)
                    .toList())
            : groupQuestion)
        .toList();
    state = [...newState];

    return true;
  }
}
