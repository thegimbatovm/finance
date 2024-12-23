
import 'constants.dart';

deleteCategory(int id) async {
  await supabase
      .from('category')
      .delete()
      .eq('id', id);
}