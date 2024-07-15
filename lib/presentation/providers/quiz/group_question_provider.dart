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
  final localDatasource = ref.read(fakeDatasourceProvider);

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

// GROUP QUESTION PROVIDER / FAVORITES -----------------------------------------
@riverpod
class GroupQuestion extends _$GroupQuestion {
  @override
  List<GroupQuestions> build() {
    return [];
  }

  void getAllGroupQuestions({required String userId}) async {
    state = [...await ref.read(getAllGroupQuestionsProvider)(data: userId)];
  }

  void createGroupQuestion(GroupQuestions groupQuestion) async {
    final result = await ref.read(createGroupQuestionProvider).call(
          data: groupQuestion,
        );
    if (!result) return;
    state = [...state, groupQuestion];
  }

  void insertQuestionInGroup(
      {required Question question, required String groupId}) async {
    final result = await ref
        .read(addQuestionInGroupProvider)
        .call(data: question, groupId: groupId);

    if (!result) return;

    final newState = state.map((groupQuestion) => groupQuestion
        .copyWith(questions: [...groupQuestion.questions, question]));
    state = [...newState];
  }
}
