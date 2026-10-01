import Agentic
import AgenticIO

public extension CoreSkillProvider {
    static let refactoringPlan = AgentSkill(
        identifier: "refactoring-plan",
        name: "Refactoring plan",
        summary: "Plan refactors as explicit, reviewable phases with stable behavior boundaries.",
        body: """
        Use a phased refactoring workflow.

        Workflow:
        1. Identify the behavior that must remain stable.
        2. Identify the API, naming, or structure that should change.
        3. Map call sites before changing shared declarations.
        4. Break the refactor into small phases:
           - introduce or rename the new shape
           - migrate call sites
           - remove obsolete compatibility code
           - clean up redundant helpers
        5. Prefer mechanical edits when the target pattern is clear.
        6. Keep each phase buildable or at least easy to review.
        7. Summarize what changed and what remains.

        Tool use:
        - Use `\(SystemIO.Tools.FindPaths.identifier.rawValue)` to rank likely affected files when no structural domain tool exists.
        - Use `\(SystemIO.Tools.SearchSources.identifier.rawValue)` to locate definitions, usages, compatibility names, and representative call sites across those sources.
        - Use `\(SystemIO.Tools.LoadSearchContext.identifier.rawValue)` to admit only the source regions needed to understand the refactor boundary.
        - Use `\(SystemIO.Tools.ReadFile.identifier.rawValue)` for direct inspection when an exact file or range is already known.
        - Use `\(SystemIO.Tools.ScanPaths.identifier.rawValue)` when package or directory topology affects the migration.
        - Use `\(SystemIO.Tools.MutateFiles.identifier.rawValue)` with edit_text for targeted migrations.
        - Avoid whole-file replacement unless the refactor is naturally file-scoped.

        Boundaries:
        - Do not mix refactoring with feature changes.
        - Do not change public behavior unless explicitly requested.
        - Do not rename concepts inconsistently.
        - Do not leave old and new names coexisting unless there is a deliberate compatibility phase.
        """,
        metadata: .init(
            domains: [
                .core
            ],
            tools: .init(
                optional: [
                    .tool(SystemIO.Tools.FindPaths.identifier),
                    .tool(SystemIO.Tools.SearchSources.identifier),
                    .tool(SystemIO.Tools.LoadSearchContext.identifier),
                    .tool(SystemIO.Tools.ScanPaths.identifier),
                    .tool(SystemIO.Tools.ReadFile.identifier),
                    .tool(SystemIO.Tools.MutateFiles.identifier)
                ]
            ),
            tags: [
                "core",
                "refactoring",
                "planning"
            ],
            attributes: [
                "pack": "base",
                "kind": "workflow"
            ]
        )
    )
}

