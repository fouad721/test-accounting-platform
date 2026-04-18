-- ═══════════════════════════════════════════════
-- نظام بريمول - قاعدة البيانات (Supabase)
-- انسخ هذا الكود وشغله في Supabase SQL Editor
-- ═══════════════════════════════════════════════

-- جدول الفواتير
create table public.invoices (
  id           bigserial primary key,
  created_at   timestamp with time zone default now(),
  inv_date     date,
  customer     text,
  branch       text,
  total        numeric(12,4) default 0,
  total_cost   numeric(12,4) default 0,
  profit       numeric(12,4) default 0,
  total_meters numeric(12,4) default 0,
  month_name   text,
  items        jsonb,
  user_email   text
);

-- صلاحيات (Row Level Security)
alter table public.invoices enable row level security;

-- السماح للمستخدمين المسجلين بقراءة وكتابة الفواتير
create policy "Allow authenticated users full access"
  on public.invoices
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

-- فهارس لتسريع البحث
create index idx_invoices_date    on public.invoices(inv_date);
create index idx_invoices_branch  on public.invoices(branch);
create index idx_invoices_month   on public.invoices(month_name);
create index idx_invoices_email   on public.invoices(user_email);

-- ════════════════════════════════════════
-- تعليمات الإعداد:
-- 1. اذهب إلى supabase.com وأنشئ مشروعاً مجانياً
-- 2. في القائمة: SQL Editor → New query
-- 3. الصق الكود أعلاه واضغط Run
-- 4. اذهب إلى Project Settings → API
-- 5. انسخ: Project URL و anon/public key
-- 6. افتح ملف بريمول HTML وغيّر:
--    const SUPA_URL = 'https://xxx.supabase.co';
--    const SUPA_KEY = 'eyJxxxxxxxx...';
-- 7. لإنشاء مستخدمين: Authentication → Users → Add user
-- ════════════════════════════════════════
