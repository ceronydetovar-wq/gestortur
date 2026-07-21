-- SQL para crear las tablas del gestor en Supabase
-- Ejecuta este script desde SQL Editor de Supabase

create extension if not exists pgcrypto;

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  start_date date,
  end_date date,
  status text default 'Planificado',
  progress int default 0,
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  created_by uuid,
  updated_by uuid
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  project_id uuid references public.projects(id) on delete set null,
  title text not null,
  start_date date,
  due_date date,
  responsible text,
  priority text default 'Media',
  status text default 'Planificado',
  progress int default 0,
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  created_by uuid,
  updated_by uuid
);

create table if not exists public.requests (
  id uuid primary key default gen_random_uuid(),
  identifier text,
  sender text,
  date date,
  time text,
  notes text,
  priority text default 'Media',
  status text default 'Pendiente',
  type text default 'Atender',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  created_by uuid,
  updated_by uuid
);

create table if not exists public.communications (
  id uuid primary key default gen_random_uuid(),
  project_id uuid references public.projects(id) on delete set null,
  identifier text,
  recipient text,
  date date,
  subject text,
  notes text,
  type text default 'Oficio',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  created_by uuid,
  updated_by uuid
);

create table if not exists public.activities (
  id uuid primary key default gen_random_uuid(),
  date date,
  time text,
  person text,
  notes text,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  created_by uuid,
  updated_by uuid
);

create table if not exists public.events (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  date date,
  time text,
  location text,
  notes text,
  type text default 'Reunión',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  created_by uuid,
  updated_by uuid
);

alter table public.projects enable row level security;
alter table public.tasks enable row level security;
alter table public.requests enable row level security;
alter table public.communications enable row level security;
alter table public.activities enable row level security;
alter table public.events enable row level security;

drop policy if exists "Permitir lectura para usuarios autenticados" on public.projects;
drop policy if exists "Permitir escritura para usuarios autenticados" on public.projects;
create policy "Permitir lectura para usuarios autenticados" on public.projects
  for select using (auth.role() = 'authenticated');
create policy "Permitir escritura para usuarios autenticados" on public.projects
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "Permitir lectura para usuarios autenticados" on public.tasks;
drop policy if exists "Permitir escritura para usuarios autenticados" on public.tasks;
create policy "Permitir lectura para usuarios autenticados" on public.tasks
  for select using (auth.role() = 'authenticated');
create policy "Permitir escritura para usuarios autenticados" on public.tasks
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "Permitir lectura para usuarios autenticados" on public.requests;
drop policy if exists "Permitir escritura para usuarios autenticados" on public.requests;
create policy "Permitir lectura para usuarios autenticados" on public.requests
  for select using (auth.role() = 'authenticated');
create policy "Permitir escritura para usuarios autenticados" on public.requests
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "Permitir lectura para usuarios autenticados" on public.communications;
drop policy if exists "Permitir escritura para usuarios autenticados" on public.communications;
create policy "Permitir lectura para usuarios autenticados" on public.communications
  for select using (auth.role() = 'authenticated');
create policy "Permitir escritura para usuarios autenticados" on public.communications
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "Permitir lectura para usuarios autenticados" on public.activities;
drop policy if exists "Permitir escritura para usuarios autenticados" on public.activities;
create policy "Permitir lectura para usuarios autenticados" on public.activities
  for select using (auth.role() = 'authenticated');
create policy "Permitir escritura para usuarios autenticados" on public.activities
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');

drop policy if exists "Permitir lectura para usuarios autenticados" on public.events;
drop policy if exists "Permitir escritura para usuarios autenticados" on public.events;
create policy "Permitir lectura para usuarios autenticados" on public.events
  for select using (auth.role() = 'authenticated');
create policy "Permitir escritura para usuarios autenticados" on public.events
  for all using (auth.role() = 'authenticated') with check (auth.role() = 'authenticated');
