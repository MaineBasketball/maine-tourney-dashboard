import { NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";
import { Resend } from "resend";
import twilio from "twilio";

const prisma = new PrismaClient();

export async function GET() {
  const resend = new Resend(process.env.RESEND_API_KEY!);
  const tw = twilio(process.env.TWILIO_ACCOUNT_SID!, process.env.TWILIO_AUTH_TOKEN!);

  const subs = await prisma.subscriber.findMany({ where: { isEnabled: true } });

  if (!subs.length) {
    return NextResponse.json({ ok: false, error: "No enabled subscribers found." }, { status: 400 });
  }

  const msg = `✅ Tourney Watch test ping (${new Date().toLocaleString()}). If you got this, email + SMS are working.`;

  // Email (to all enabled)
  await resend.emails.send({
    from: process.env.RESEND_FROM!,
    to: subs.map(s => s.email),
    subject: "Tourney Watch: test alert",
    text: msg,
  });

  // SMS (send individually)
  await Promise.allSettled(
    subs.map(s =>
      tw.messages.create({
        from: process.env.TWILIO_FROM_NUMBER!,
        to: s.phone,
        body: msg,
      })
    )
  );

  return NextResponse.json({ ok: true, sentTo: subs.length });
}