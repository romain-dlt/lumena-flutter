import 'package:lumena_ai/services/iap_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MonthlyEditsService {
  static Future<bool> consumeEdit() async {
    final isPro = await IAPService.isPro();
    final canEdit = await Supabase.instance.client.rpc(
      'consume_edit',
      params: {'is_premium': isPro},
    );

    return canEdit;
  }

  static Future<int> getRemainingEdits() async {
    final isPro = await IAPService.isPro();
    final remainingEdits = await Supabase.instance.client.rpc(
      'get_remaining_edits',
      params: {'is_premium': isPro},
    );

    return remainingEdits as int;
  }

  static Future<int> getUsedEdits() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;

    final data = await Supabase.instance.client
        .from('monthly_edits')
        .select('edits_used')
        .eq('user_id', userId)
        .maybeSingle();

    if (data == null) {
      return 10;
    }

    return data['edits_used'] as int;
  }

  static Future<void> removeOneUsedEdit() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final currentEditsUsed = await getUsedEdits();

    await Supabase.instance.client
        .from('monthly_edits')
        .update({'edits_used': currentEditsUsed - 1})
        .eq('user_id', userId);
  }
}
